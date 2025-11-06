<?php

namespace App\Http\Controllers;

use App\Http\Resources\StoryResource;
use App\Models\Story;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;

class StoryController extends Controller
{
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
        try {
            $request->validate([
                'Word'      => 'required|string',
                'Place'     => 'required|string',
                'Title'     => 'sometimes|string',
                'Content'   => 'required|string',
                'Words'     => 'required|numeric',
                'UserId'    => 'required|exists:users,id',
            ]);


            DB::beginTransaction();
            $story = Story::query()->create([
                'story_token'   => Str::uuid()->toString(),
                'random_word'   => $request->Word,
                'random_place'  => $request->Place,
                'title'         => $request->Title,
                'content'       => $request->Content,
                'word_count'    => $request->Words ?? 0,
                'user_id'       => $request->UserId,
            ]);
            DB::commit();

            return response()->json([
                "success" => true,
                "message" => "Escrito creado",
                $story
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
            $request->validate([
                'story_token' => $request->storyToken,
                
                'Title'     => 'sometimes|string',
                'Content'   => 'required|string',
                'Words'     => 'required|numeric',
                'UserId'    => 'required|exists:users,id',
            ]);

            $story = Story::query()->where(['story_token' => $request->storyToken])->first();

            if (!$story) {
                return response()->json([
                    "success" => false,
                    "error" => "No se encontró el escrito"
                ], Response::HTTP_NOT_FOUND);
            }

            DB::beginTransaction();

            $story->update([
                'random_word'   => $request->Word ?? $story->random_word,
                'random_place'  => $request->Place ?? $story->random_place,
                'title'         => $request->Title ?? $story->title,
                'content'       => $request->Content ?? $story->content,
                'word_count'    => $request->Words ?? $story->word_count,
                'user_id'       => $request->UserId ?? $story->user_id,
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
