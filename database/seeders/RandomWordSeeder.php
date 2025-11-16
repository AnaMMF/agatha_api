<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;


class RandomWordSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $words = [
            'llave',
            'reloj',
            'diario',
            'espada',
            'botella',
            'pluma',
            'libro',
            'vela',
            'sombrero',
            'anillo',
            'caja',
            'puerta',
            'espejo',
            'carta',
            'mapa',
            'piedra',
            'linterna',
            'bolsillo',
            'cámara',
            'brújula',
            'cristal',
            'retrato',
            'baraja',
            'frasco',
            'bolígrafo',
            'cuerda',
            'escudo',
            'telescopio',
            'vara',
            'moneda',
            'flores',
            'frasco',
            'llavero',
            'pergamino',
            'retrato',
            'bastón',
            'maleta',
            'collar',
            'cuaderno',
            'botón',
            'ventana',
            'candado',
            'caracola',
            'reloj de arena',
            'pañuelo',
            'figura',
            'globo',
            'paraguas',
            'pincel',
            'ancla'
        ];

        $places = [
            'París',
            'Londres',
            'Roma',
            'Tokio',
            'Madrid',
            'Berlín',
            'Lisboa',
            'Nueva York',
            'Buenos Aires',
            'Lima',
            'Sídney',
            'Toronto',
            'Ámsterdam',
            'Oslo',
            'Dublín',
            'El Cairo',
            'Estambul',
            'Praga',
            'Venecia',
            'Sevilla',
            'Granada',
            'Barcelona',
            'Valencia',
            'Bilbao',
            'Marrakech',
            'Kioto',
            'Nápoles',
            'Florencia',
            'Copenhague',
            'Reikiavik',
            'Zúrich',
            'Dubái',
            'Chicago',
            'San Francisco',
            'Los Ángeles',
            'Río de Janeiro',
            'Bogotá',
            'Montevideo',
            'Santiago',
            'Quito',
            'Edimburgo',
            'Bruselas',
            'Budapest',
            'Varsovia',
            'Helsinki',
            'Estocolmo',
            'Ginebra',
            'Casablanca',
            'Manila',
            'Singapur'
        ];
        $data = [];

        foreach ($words as $word) {
            $data[] = ['type' => 'word', 'value' => $word];
        }

        foreach ($places as $place) {
            $data[] = ['type' => 'place', 'value' => $place];
        }

        DB::table('random_words')->insert($data);
    }
}
