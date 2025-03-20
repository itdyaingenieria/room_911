<template>

    <Head title="Departaments" />
    <AuthenticatedLayout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Departments in room_911
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <Link :href="route('departments.create')"
                            class="bg-blue-500 text-white px-4 py-2 rounded-md mb-4 inline-block"
                            title="Add Department in the system">
                        Add Department
                        </Link>

                        <table class="min-w-full">
                            <thead>
                                <tr>
                                    <th
                                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Name
                                    </th>
                                    <th
                                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr v-for="department in departments" :key="department.id">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        {{ department.name }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <Link :href="route('departments.edit', department.id)"
                                            class="text-indigo-600 hover:text-indigo-900 mr-2">
                                        Editar
                                        </Link>
                                        <button @click="deleteDepartment(department.id)"
                                            class="text-red-600 hover:text-red-900">
                                            Eliminar
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, router } from '@inertiajs/vue3';

defineProps({
    departments: Array,
});

const deleteDepartment = (id) => {
    if (confirm('¿Estás seguro de eliminar este departamento?')) {
        router.delete(route('departments.destroy', id));
    }
};
</script>