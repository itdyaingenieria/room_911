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
        // validate if the user is a superuser and is authenticated
        if ($request->user() && $request->user()->is_superuser) {
            return $next($request);
        }

        Log::info('Middleware EnsureUserIsSuperuser execute for: ' . $request->url());

        // Redirect to the home page dashboard with an error message
        return redirect('/dashboard')->with('error', 'You do not have permission to access this page.');
    }
}
