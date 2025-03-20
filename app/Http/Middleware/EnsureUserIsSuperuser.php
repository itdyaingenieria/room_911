<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureUserIsSuperuser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Verificar si el usuario está autenticado y es un superusuario
        if ($request->user() && $request->user()->is_superuser) {
            return $next($request);
        }

        Log::info('Middleware EnsureUserIsSuperuser execute for: ' . $request->url());

        // Redirigir a la página de inicio o mostrar un error
        return redirect('/')->with('error', 'You do not have permission to access this page.');
    }
}
