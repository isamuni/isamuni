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
                author: 0,
                no_limit: true
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
    computed: {
        sources_ready: function() {
            return Object.keys(this.sources).length > 0;
        }
    },
    methods: {
        updatePosts() {
            DataSource.getPosts(this.filter).then((posts) => {
                this.posts = posts;
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
