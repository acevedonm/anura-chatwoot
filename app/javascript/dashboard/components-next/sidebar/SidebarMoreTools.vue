<script setup>
import { computed, ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRoute } from 'vue-router';
import { useSidebarContext } from './provider';
import SidebarGroup from './SidebarGroup.vue';

const props = defineProps({
  items: { type: Array, required: true },
});

const { t } = useI18n();
const route = useRoute();
const { isCollapsed, isAllowed, resolvePath } = useSidebarContext();
const isOpen = ref(false);

const isAccessible = item =>
  item.children
    ? item.children.some(isAccessible)
    : item.to && isAllowed(item.to);
const visibleItems = computed(() => props.items.filter(isAccessible));

const isActive = item => {
  if (item.activeOn?.includes(route.name)) return true;
  if (item.to) {
    const path = resolvePath(item.to);
    if (route.path === path || route.path.startsWith(`${path}/`)) return true;
  }
  return item.children?.some(isActive) || false;
};

watch(
  () => route.fullPath,
  () => {
    if (visibleItems.value.some(isActive)) isOpen.value = true;
  },
  { immediate: true }
);
</script>

<!-- eslint-disable-next-line vue/no-root-v-if -->
<template>
  <li
    v-if="visibleItems.length"
    class="grid gap-1 min-w-0 mt-3 pt-3 border-t border-n-weak"
  >
    <button
      type="button"
      class="flex items-center gap-2 rounded-lg text-n-slate-11 hover:bg-n-alpha-2 focus-visible:outline focus-visible:outline-2 focus-visible:outline-n-brand"
      :class="isCollapsed ? 'size-10 justify-center' : 'h-8 w-full px-1.5 py-1'"
      :title="t('SIDEBAR.MORE_TOOLS')"
      :aria-label="t('SIDEBAR.MORE_TOOLS')"
      :aria-expanded="isOpen"
      aria-controls="sidebar-more-tools"
      @click="isOpen = !isOpen"
    >
      <span class="i-lucide-ellipsis size-4 flex-shrink-0" />
      <template v-if="!isCollapsed">
        <span class="flex-grow text-start truncate">
          {{ t('SIDEBAR.MORE_TOOLS') }}
        </span>
        <span
          class="size-3 flex-shrink-0"
          :class="isOpen ? 'i-lucide-chevron-up' : 'i-lucide-chevron-down'"
        />
      </template>
    </button>
    <ul
      v-show="isOpen"
      id="sidebar-more-tools"
      class="flex flex-col gap-1 m-0 list-none min-w-0"
      :class="{ 'items-center': isCollapsed }"
    >
      <SidebarGroup
        v-for="item in visibleItems"
        :key="item.name"
        v-bind="item"
      />
    </ul>
  </li>
</template>
