<?php

namespace Database\Seeders;

use App\Models\doctor;
use Illuminate\Database\Seeder;

class doctorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        for ($i=0; $i <20 ; $i++) {
            doctor::create([
                'name'          => 'Ali'.$i.'Alashrafov',
                'email'         => 'example'.$i.'@test.me',
                'password'         => bcrypt('thepassword'),
                'address'       => 'Prague '.$i.' steet',
                'phone'         => "+420777193298",
                'department'         => rand(1,5),
                'specialization'         => "'.$i+1.'MBBS '.$i.'",
                'photo_path'    => env('APP_URL').'images/'. 'doctor_01.jpg',
            ]);
        }
    }
}
