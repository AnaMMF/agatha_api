<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!Auth::attempt($data)) {
            return response()->json(['success' => false, 'message' => 'Incorrecto'], 401);
        }

        $user = $request->user();
        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'success' => true,
            'token' => $token,
            'user' => $user,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return response()->json(['success' => true, 'message' => 'Sesión cerrada']);
    }


    /**
 * Registra un nuevo usuario y devuelve un token Sanctum.
 */
public function register(Request $request)
{
    $data = $request->validate([
        'name' => 'required|string|max:255',
        'email' => 'required|string|email|max:255|unique:users,email',
        'password' => 'required|string|min:6|confirmed',
    ]);

    // Cifrar la contraseña
    $data['password'] = bcrypt($data['password']);

    $user = \App\Models\User::create($data);

    // Crear un token Sanctum inmediatamente
    $token = $user->createToken('api-token')->plainTextToken;

    return response()->json([
        'success' => true,
        'message' => 'Usuario registrado correctamente',
        'token' => $token,
        'user' => $user,
    ], 201);
}


    public function me(Request $request)
    {
        return response()->json(['user' => $request->user()]);
    }
}
