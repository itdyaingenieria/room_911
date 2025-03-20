<template>
    <GuestLayout>

        <Head title="Access Simulator" />
        <div>
            <h1 class="mb-6 font-semibold text-xl text-gray-800 leading-tight text-center">Access Simulator</h1>
            <div class="mb-6">
                <input v-model="employeeId" placeholder="Enter Employee ID"
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" />
            </div>
            <div class="flex justify-center space-x-4">
                <button @click="validateAccess"
                    class="flex items-center gap-2  bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                    <ArrowRightStartOnRectangleIcon class="w-5 h-5" /> Access
                </button>
            </div>
            <p v-if="message">{{ message }}</p>
        </div>
    </GuestLayout>
</template>

<script setup>
import { ref } from 'vue';
import { Head, router } from '@inertiajs/vue3';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { ArrowRightStartOnRectangleIcon } from '@heroicons/vue/24/solid';

const employeeId = ref('');
const message = ref('');

const validateAccess = async () => {
    try {
        const response = await axios.post('/validate-access', {
            employeeId: employeeId.value,
        });
        console.log(response.data);
        if (response.data.success) {
            router.visit('/dashboard'); // Redirige al dashboard si el acceso es válido
        } else {
            message.value = response.data.message;
        }
    } catch (error) {
        message.value = 'Error validating access';
    }
};
</script>