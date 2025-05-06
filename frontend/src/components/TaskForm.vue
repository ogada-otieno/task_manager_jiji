<template>
  <div class="form-container">
    <h2>Create New Task</h2>
    <div v-if="error" class="alert alert-error">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="18"
        height="18"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        style="margin-right: 10px"
      >
        <circle cx="12" cy="12" r="10"></circle>
        <line x1="12" y1="8" x2="12" y2="12"></line>
        <line x1="12" y1="16" x2="12.01" y2="16"></line>
      </svg>
      {{ error }}
    </div>
    <form @submit.prevent="submitTask">
      <div class="form-group">
        <label for="title">Task Title*</label>
        <input
          id="title"
          type="text"
          placeholder="What needs to be done?"
          v-model="form.title"
          :class="{ error: titleError }"
          autocomplete="off"
        />
        <p v-if="titleError" class="error-message">{{ titleError }}</p>
      </div>

      <div class="form-group">
        <label for="description">Description</label>
        <textarea
          id="description"
          placeholder="Add details about this task (optional)"
          v-model="form.description"
          rows="3"
        ></textarea>
      </div>

      <div>
        <button type="submit" :disabled="isLoading">
          <span v-if="isLoading">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="animation: spin 1s linear infinite; margin-right: 8px"
            >
              <path d="M21 12a9 9 0 1 1-6.219-8.56"></path>
            </svg>
            Creating...
          </span>
          <span v-else>Create Task</span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, reactive, defineProps, defineEmits } from 'vue';

defineProps({
  isLoading: Boolean,
});

const emit = defineEmits(['submit']);

const form = reactive({
  title: '',
  description: '',
  completed: false,
});

const error = ref('');
const titleError = ref('');

const submitTask = () => {
  // Reset errors
  error.value = '';
  titleError.value = '';

  // Validate title
  if (!form.title.trim()) {
    titleError.value = 'Please enter a task title';
    return;
  }

  // Emit the task data to parent component
  emit('submit', { ...form });

  // Reset form after submission
  form.title = '';
  form.description = '';
};
</script>

<style scoped>
@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
