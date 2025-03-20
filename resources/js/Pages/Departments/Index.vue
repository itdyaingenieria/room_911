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
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg ">
                    <div class=" p-6 bg-white border-b border-gray-200 ">

                        <div class="flex flex-wrap justify-end gap-4 mb-6">
                            <Link :href="route('departments.create')"
                                class=" gap-4 bg-blue-500 text-white px-4 py-2 rounded-md mb-4 inline-block items-center "
                                title="Add Department in the system">
                            Add Department
                            </Link>
                        </div>

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
                                    <td class="flex space-x-2 items-center px-6 py-4 whitespace-nowrap">
                                        <button @click="editDepartment(department.id)"
                                            class="flex items-center gap-2 bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-3 rounded-xl">
                                            <ArrowPathIcon class="w-5 h-5" /> Update
                                        </button>
                                        <button @click="deleteDepartment(department.id)"
                                            class="flex items-center gap-2 bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-3 rounded-xl">
                                            <TrashIcon class="w-5 h-5" /> Delete
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
import { ArrowPathIcon, TrashIcon, FunnelIcon, XMarkIcon, ArrowUpTrayIcon } from '@heroicons/vue/24/solid';


defineProps({
    departments: Array,
});
// Navigate to the department editing page
const editDepartment = (id) => {
    router.visit(`/departments/${id}/edit`);
};

// Delete employee
const deleteDepartment = (id) => {
    if (confirm('¿Estás seguro de eliminar este departamento?')) {
        router.delete(route('departments.destroy', id)); //call name of the route
    }
};
</script>