<template>
<div id="feedapp">
    <div v-if="loading" class="row">
        <div class="col-3">
            <p>Caricamento in corso</p>
        </div>
    </div>
    <div v-else class="row">
        <div class="col-5">
            <multiselect :options="months" label="label" :multiple="false" :close-on-select="true" v-model="selectedMonth" placeholder="Scegli un mese" />
        </div>
        <div class="col-6">
            <multiselect :options="sources" :multiple="true" :close-on-select="true" v-model="selectedSources" placeholder="Filtra per fonti" label="name" />
            <p>
                <label for="jobs_only">Solo annunci di lavoro</label> <input id="jobs_only" type="checkbox" value="false" v-model="jobsOnly"></input>
                <label for="as_list">Mostra come tabella</label> <input id="as_list" type="checkbox" value="false" v-model="asList"></input>

            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <PostDisplay :posts="filteredPosts" :as-list="asList"></PostDisplay>
        </div>
    </div>
</div>
</template>

<script>
import PostDisplay from './PostDisplay.vue';
import Multiselect from 'vue-multiselect';

/* Main app
   Contains both filters and postDisplay
   listens to events from filters, and stores the last version in data
   the filters are then passed to postDisplay as props */

/* global console, DataSource, $ */

var Feed = {
    data: function() {
        return {
            sources: [],
            selectedSources: [],
            posts: [],
            selectedMonth: null,
            months: [],
            loading: true,
            jobsOnly: false,
            asList: true
        };
    },
    mounted: function() {
        $.when(DataSource.getSources(), this.getMonths())
            .then((sources) => {
                this.sources = sources;
                this.loading = false;
            });
    },
    computed: {
        request_filters() {
            let startD = null;
            let endD = null;
            if (this.selectedMonth) {
                startD = new Date(this.selectedMonth.id);
                endD = new Date(this.selectedMonth.id);
                endD.setMonth(startD.getMonth() + 1);
                startD = startD.getTime();
                endD = endD.getTime();
            }
            return {
                sources: "",
                start: startD,
                end: endD,
                jobs_only: this.jobsOnly,
                limit: 100
            };
        },
        filteredPosts() {
            let selectedIDs = this.selectedSources.map((e) => e.id);
            return this.posts.filter((post) => !selectedIDs.length || selectedIDs.includes(post.source_id));
        }
    },
    watch: {
        request_filters: {
            handler: function() {
                this.updatePosts();
            },
            deep: true
        }
    },
    methods: {
        updatePosts() {
            return DataSource.getPosts(this.request_filters).then((posts) => {
                this.posts = posts;
            });
        },
        getMonths() {
            return $.getJSON("/feed/count_by_month")
                .then((data) => {
                    if (data) {
                        this.months = data.map(x => ({
                            id: x[0],
                            label: `${x[0]} (${x[1]} post)`
                        }));
                        this.selectedMonth = this.months[0];
                    }
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
        PostDisplay,
        Multiselect
    }
};

export default Feed;
</script>

<style>

</style>
