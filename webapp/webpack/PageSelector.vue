<template>
    <Multiselect
      :options="pages"
      :searchable="true"
      v-model="selected"
      placeholder="Scegli pagina"
      label="name"
      key="id" ></Multiselect>
</template>

<script>

/* global $ */

import Multiselect from 'vue-multiselect';

let PageSelector = {
  mounted: function() {
      let pages = $.getJSON('/pages.json');

      pages.then((pages) => {
          this.pages = pages;
      });
  },
  data: function() {
    return {
      pages: [],
      selected: null
    };
  },
  components: {
    Multiselect
  }
};

export default PageSelector;

</script>

<style>
</style>
