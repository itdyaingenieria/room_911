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
                <!-- Access Button -->
                <button @click="validateAccess"
                    class="flex items-center gap-2 bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded-xl focus:outline-none focus:shadow-outline">
                    <ArrowRightStartOnRectangleIcon class="w-5 h-5" />
                    Access
                </button>

                <!-- Go Home Button -->
                <GoHomeDfya @click="goHome">
                </GoHomeDfya>

            </div>

            <!-- Show error or success message-->
            <p v-if="message" class="text-red-500 text-center mt-4 font-bold">{{ message }}</p>
        </div>
    </GuestLayout>
</template>

<script setup>
import { ref } from 'vue';
import { Head, router, usePage } from '@inertiajs/vue3';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { ArrowRightStartOnRectangleIcon } from '@heroicons/vue/24/solid';
import GoHomeDfya from '@/Components/GoHomeDfya.vue';
import axios from 'axios';

const employeeId = ref('');
const message = ref('');

// Errors from the server
const page = usePage();
console.log(page.props);
if (page.props.flash?.error) {
    message.value = page.props.flash.error;
}

// Validate access to the system
const validateAccess = async () => {
    try {
        const response = await axios.post('/validate-access', {
            employeeId: employeeId.value,
        },
            {
                validateStatus: (status) => status < 500
            });
        console.log(response.data);
        if (response.data.success) {
            message.value = response.data.message;
            setTimeout(() => {
                router.visit('/access-simulator/dashboard');
            }, 1000);
        } else {
            message.value = response.data.message;
        }
    } catch (error) {
        message.value = 'An unexpected error occurred';
    }
};

// Go Home Function
const goHome = () => {
    router.visit('/');
};
</script>
