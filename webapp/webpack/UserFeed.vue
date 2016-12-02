<template>
<div id="feedapp">
    <PostDisplay v-if="sources_ready" :posts="posts"></PostDisplay>
</div>
</template>

<script>
import PostDisplay from './PostDisplay.vue';

/* Main app
   Contains both filters and postDisplay
   listens to events from filters, and stores the last version in data
   the filters are then passed to postDisplay as props */

/* global $, console */

var UserFeed = {
    data: function() {
        return {
            sources: [],
            filter: {
                sources: "",
                start: null,
                end: null,
                jobs_only: 0
            },
            posts: []
        };
    },
    mounted: function() { // TODO - get only this user feed
        let sources = $.getJSON('/feed/sources.json');

        sources.then((sources) => {
            this.sources = sources;
            this.updatePosts();
        });
    },
    computed: {
        sources_ready: function() {
            return Object.keys(this.sources).length > 0;
        }
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
        updatePosts() {
            let _this = this;
            let result = $.getJSON('/feed/posts.json', this.filter);

            result.then(function(posts) {
                posts.forEach(function(post) {
                    post['source'] = _this.sources.find((s) => s.id == post['source_id']) || {};
                });
                _this.posts = posts;
            });
        }
    },
    components: {
        PostDisplay
    }
};

export default UserFeed;
</script>

<style>

</style>
