<template>
<div id="feedapp">
  <div id="dashboard_div" class="row">
    <div class="col-md-3">
      <p>FILTRI</p>
    </div>
    <div class="col-md-9">
      <i id="spinner" class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
      <div class="row">
        <div id="chart_div" data-intro="Questo grafico mostra tutti i post della community nel tempo."></div>
      </div>
      <div class="row">
        <div id="filter_div" data-intro="Usa lo slider per trovare i post più vecchi."></div>
      </div>
    </div>
  </div>
  <hr>
  <PostDisplay v-if="sources_ready" :filter="{}" :sources="sources"></PostDisplay>
</div>
</template>

<script>

import PostDisplay from './PostDisplay.vue';

/* Main app 
   Contains both filters and postDisplay
   listens to events from filters, and stores the last version in data
   the filters are then passed to postDisplay as props */

var Feed = {
  data: function(){
    return {sources: {}};
  },
  mounted: function(){
    $.ajax({
      url: '/feed/sources.json',
      success: (res) => this.sources = res,
    });
  },
  computed: {
    sources_ready: function(){
      return Object.keys(this.sources).length > 0;
    }
  },
  components: { PostDisplay }
};

export default Feed;

</script>

<style>

</style>
