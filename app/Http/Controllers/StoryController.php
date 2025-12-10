<?php

namespace App\Http\Controllers;

use App\Http\Resources\StoryResource;
use App\Models\RandomWord;
use App\Models\Story;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;
use App\Traits\WordCountTrait;


class StoryController extends Controller
{
    use WordCountTrait;

    public function randomWords(): JsonResponse
    {
        try {
            $word = \App\Models\RandomWord::where('type', 'word')->inRandomOrder()->value('value');
            $place = \App\Models\RandomWord::where('type', 'place')->inRandomOrder()->value('value');

            if (!$word || !$place) {
                return response()->json([
                    'success' => false,
                    'message' => 'No hay suficientes palabras o lugares en la base de datos.'
                ], Response::HTTP_NOT_FOUND);
            }

            return response()->json([
                'success' => true,
                'word' => $word,
                'place' => $place,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }


    /**
     * Devuelve un listado de historias del usuario.
     *      TODO: esto devuelve todos los registros de historias!
     * 
     *      
     * @param string $userToken
     * @return JsonResponse
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();
        //$user = \App\Models\User::first();
        $stories = Story::query()->where(['user_id' => $user->id])->get();

        if ($stories->isEmpty()) {
            return response()->json([
                "success" => false,
                "error" => "No se encontraron escritos"
            ], Response::HTTP_OK);
        }

        //$stories = StoryResource::collection(Story::all()); //todas las historias de todos los usuarios
        $stories = StoryResource::collection($stories);

        return response()->json([
            "success" => true,
            "message" => "Listado de escritos",
            "historias" => $stories
        ]);
    }

    /**
     * Guarda una nueva historia.
     *
     * @param Request $request
     * @return JsonResponse
     * @throws \Throwable
     */
    public function store(Request $request): JsonResponse
    {
        \Log::info("STORE REQUEST:", $request->all());

        try {
            $request->validate([
                'title'     => 'sometimes|string',
                'content'   => 'required|string',
                'user_id'   => 'required|exists:users,id',
                'word'      => 'required|string',
                'place'     => 'required|string',
            ]);


            $word = $request->word;
            $place = $request->place;

            if ( //stripos busca sin importarle mayus y minusculas
                stripos($request->content, $word) === false ||
                stripos($request->content, $place) === false
            ) {
                return response()->json([
                    "success" => false,
                    "message" => "La historia debe incluir la palabra '{$word}' y el lugar '{$place}'."
                ], Response::HTTP_UNPROCESSABLE_ENTITY);
            }


            DB::beginTransaction();
            $story = Story::query()->create([
                'story_token'   => Str::uuid()->toString(),
                'random_word'   => $request->word,
                'random_place'  => $request->place,
                'title'         => $request->title,
                'content'       => $request->content,
                'word_count'    => $this->countWords($request->content),
                'user_id'       => $request->user_id,
            ]);

            DB::commit();

            // actualiza actividad del usuario
            $status = $story->user->inactivity;

            if ($status) {
                // resetea el ciclo de inactividad
                $status->update([
                    'last_story_at' => now(),
                    'first_email_sent_at' => null,
                    'second_email_sent_at' => null,
                ]);
            } else {
                // crear registro si no existe
                $story->user->inactivity()->create([
                    'last_story_at' => now(),
                ]);
            }

            return response()->json([
                "success" => true,
                "message" => "Escrito creado",
                "story"   => new StoryResource($story)
            ], Response::HTTP_CREATED);
        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                "success" => false,
                "code" => $e->getCode(),
                "message" => $e->getMessage(),
            ], Response::HTTP_BAD_REQUEST);
        }
    }

    /**
     * Display the specified resource.
     * 
     * @param string $storyToken
     * @return JsonResponse
     * @throws \Throwable
     */
    public function show(Request $request): JsonResponse
    {
        try {

            $story = Story::query()->where(['story_token' => $request->storyToken])->first();

            if (!$story) {
                return response()->json([
                    "success" => false,
                    "error" => "No se encontró el escrito"
                ], Response::HTTP_NOT_FOUND);
            }

            $story = new StoryResource($story);

            return response()->json([
                "success" => true,
                "message" => "Escrito encontrado",
                "historia" => $story
            ], Response::HTTP_OK);
        } catch (\Exception $e) {

            return response()->json([
                "success" => false,
                "code" => $e->getCode(),
                "message" => $e->getMessage(),
            ], Response::HTTP_BAD_REQUEST);
        }
    }



    /**
     * Update the specified resource in storage.
     * 
     * @param Request $request
     * @param string $storyToken
     * @return JsonResponse
     * @throws \Throwable
     */
    public function update(Request $request): JsonResponse
    {
        try {

            $story = Story::query()->where(['story_token' => $request->storyToken])->first();

            \Log::info("STORE REQUEST:", $request->all());


            if (!$story) {
                return response()->json([
                    "success" => false,
                    "error" => "No se encontró el escrito"
                ], Response::HTTP_NOT_FOUND);
            }
            $request->validate([
                'story_token' => $request->storyToken,
                'title'     => 'sometimes|string',
                'content'   => 'required|string',
                'user_id'   => 'required|exists:users,id',
            ]);

            $word = $request->word ?? $story->random_word;
            $place = $request->place ?? $story->random_place;

            if (
                stripos($request->content, $word) === false ||
                stripos($request->content, $place) === false
            ) {
                return response()->json([
                    "success" => false,
                    "message" => "La historia debe incluir la palabra '{$word}' y el lugar '{$place}'."
                ], Response::HTTP_UNPROCESSABLE_ENTITY);
            }

            DB::beginTransaction();

            $story->update([
                'title'         => $request->title ?? $story->title,
                'content'       => $request->content ?? $story->content,
                'word_count'    => $this->countWords($request->content),
                'user_id'       => $request->user_id ?? $story->user_id,
            ]);

            DB::commit();

            return response()->json([
                "success" => true,
                "message" => "Escrito actualizado"
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                "success" => false,
                "code" => $e->getCode(),
                "message" => $e->getMessage(),
            ], Response::HTTP_BAD_REQUEST);
        }
    }




    /**
     * Remove the specified resource from storage.
     *
     * @param string $storyToken
     * @return JsonResponse
     * @throws \Throwable
     */
    public function destroy(Request $request): JsonResponse
    {

        try {
            $story = Story::query()->where(['story_token' => $request->storyToken])->first();

            if (!$story) {
                return response()->json([
                    "success" => false,
                    "error" => "No se encontró el escrito"
                ], Response::HTTP_NOT_FOUND);
            }

            DB::beginTransaction();
            $story->delete();
            DB::commit();


            return response()->json([
                "success" => true,
                "message" => "Escrito eliminado"
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                "success" => false,
                "code" => $e->getCode(),
                "message" => $e->getMessage(),
            ], Response::HTTP_BAD_REQUEST);
        }
    }
}
