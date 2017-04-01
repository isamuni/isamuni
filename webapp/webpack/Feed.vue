<template>
<div id="feedapp">
    <div id="dashboard_div" class="row">
        <div class="col-3">
            <multiselect :options="sources" :multiple="true" :close-on-select="true" @input="updateFilter" placeholder="Scegli fonti" label="name" />
            <p>
                <label for="jobs_only">Solo annunci di lavoro</label> <input id="jobs_only" type="checkbox" value="false" v-model="filter.jobs_only"></input>
            </p>
        </div>
        <div class="col-9">
            <i id="spinner" class="fa fa-spinner fa-pulse fa-3x fa-fw"></i>
            <div class="row" style="display:none">
                <div id="chart_div" data-intro="Questo grafico mostra tutti i post della community nel tempo."></div>
            </div>
            <div class="row">
                <div id="filter_div" data-intro="Usa lo slider per trovare i post più vecchi."></div>
            </div>
        </div>
    </div>

    <PostDisplay :posts="posts"></PostDisplay>
</div>
</template>

<script>
import PostDisplay from './PostDisplay.vue';
import Multiselect from 'vue-multiselect';

/* Main app
   Contains both filters and postDisplay
   listens to events from filters, and stores the last version in data
   the filters are then passed to postDisplay as props */

/* global console, DataSource */

var Feed = {
    data: function() {
        return {
            sources: [],
            filter: {
                sources: "",
                start: null,
                end: null,
                jobs_only: 0,
                limit: 50
            },
            posts: []
        };
    },
    mounted: function() {
        DataSource.getSources().then((sources) => {
            this.sources = sources;
            this.updatePosts();
        });
    },
    watch: {
        filter: {
            handler: function() {
                this.updatePosts();
            },
            deep: true
        }
    },
    methods: {
        updateFilter(selectedElems) {
            let selectedIDs = selectedElems.map((e) => e.id);
            selectedIDs.sort();
            this.filter.sources = selectedIDs.join(",");
        },
        updatePosts() {
            DataSource.getPosts(this.filter).then((posts) => {
                this.posts = posts;
            });
        }
    },
    components: {
        PostDisplay,
        Multiselect
    }
};

export default Feed;
</script>

<style>

</style>
