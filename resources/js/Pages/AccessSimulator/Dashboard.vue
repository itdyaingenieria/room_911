<template>
    <div class="p-6 bg-gray-100 min-h-screen">
        <div class="max-w-4xl mx-auto bg-white p-8 rounded-lg shadow-lg">
            <h1 class="text-2xl font-bold mb-4">Welcome to the Dashboard!</h1>
            <p class="mb-6">You have successfully accessed the simulator.</p>
            <button @click="logout" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition-colors">
                Log Out
            </button>
        </div>
    </div>
</template>

<script setup>
import { router } from '@inertiajs/vue3';

const logout = () => {
    router.post('/access-simulator/logout', {}, {
        onSuccess: () => {
            localStorage.clear();
            sessionStorage.clear();
            window.location.href = '/'; // go home
        }
    });
};
</script>