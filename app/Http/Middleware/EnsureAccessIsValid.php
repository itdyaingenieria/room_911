<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Log;

class EnsureAccessIsValid
{
    public function handle(Request $request, Closure $next): Response
    {
        if ($request->routeIs('validate-access')) {
            return $next($request);
        }

        if (!$request->session()->has('employeeId')) {
            return $this->denyAccess($request, 'Access denied: No employee ID found.');
        }

        Log::info('Middleware EnsureAccessIsValid execute for: ' . $request->url());

        return $next($request);
    }

    private function denyAccess(Request $request, string $message, int $status = 403)
    {
        if ($request->expectsJson()) {
            return response()->json(['error' => $message], $status);
        }

        return redirect()->route('validate-access')->with('error', $message);
    }
}
