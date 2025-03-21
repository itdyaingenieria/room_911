<template>
    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Create Department
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <form @submit.prevent="submit">
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="name">
                                    Name of Department
                                </label>
                                <input v-model="form.name" type="text"
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="name" required />
                            </div>
                            <div class="flex items-center justify-between">
                                <button type="submit"
                                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                                    💾 Save
                                </button>
                                <Link :href="route('departments.index')"
                                    class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                                ❌ Cancel
                                </Link>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { useForm, Link } from '@inertiajs/vue3';

const form = useForm({
    name: '',
});

const submit = () => {
    form.post(route('departments.store'));
};
</script>