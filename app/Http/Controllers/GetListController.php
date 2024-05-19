<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class GetListController extends Controller
{
    private static int $test = 0;
    public function __invoke(): Response
    {
        self::$test++;
        return new JsonResponse([
            'test' => self::$test,
        ]);
    }
}
