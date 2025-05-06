<template>
  <div class="task-list">
    <h2>Your Tasks</h2>
    
    <div v-if="isLoading" class="loading-text">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="animation: spin 1s linear infinite; margin-right: 10px;">
        <path d="M21 12a9 9 0 1 1-6.219-8.56"></path>
      </svg>
      Loading your tasks...
    </div>
    
    <div v-else-if="!tasks.length" class="empty-text">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 10px;">
        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
        <line x1="9" y1="9" x2="15" y2="15"></line>
        <line x1="15" y1="9" x2="9" y2="15"></line>
      </svg>
      <p>No tasks yet. Create one above!</p>
    </div>
    
    <ul v-else style="list-style: none; padding: 0; margin: 0">
      <li v-for="task in tasks" :key="task.id" class="task-item">
        <div class="task-item-header">
          <h3>{{ task.title }}</h3>
          <button
            @click="deleteTask(task.id)"
            class="delete-btn"
            :disabled="deletingId === task.id"
          >
            <span v-if="deletingId === task.id">
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="animation: spin 1s linear infinite; margin-right: 5px;">
                <path d="M21 12a9 9 0 1 1-6.219-8.56"></path>
              </svg>
            </span>
            <span v-else>
              <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="3 6 5 6 21 6"></polyline>
                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
              </svg>
              Delete
            </span>
          </button>
        </div>
        <p v-if="task.description" class="task-description">{{ task.description }}</p>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, defineProps, defineEmits } from 'vue';

defineProps({
  tasks: Array,
  isLoading: Boolean,
});

const emit = defineEmits(['delete']);

const deletingId = ref(null);

const deleteTask = async (id) => {
  deletingId.value = id;
  emit('delete', id);
  setTimeout(() => {
    deletingId.value = null;
  }, 500);
};
</script>

<style scoped>
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.task-item-header button svg {
  margin-right: 5px;
}

.loading-text, 
.empty-text {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
</style>