<template>
<div id="feedapp">
    <PostDisplay :posts="posts"></PostDisplay>
</div>
</template>

<script>
import PostDisplay from './PostDisplay.vue';

/* Main app
   Contains both filters and postDisplay
   listens to events from filters, and stores the last version in data
   the filters are then passed to postDisplay as props */

/* global DataSource, console */

var UserFeed = {
    data: function() {
        return {
            filter: {
                sources: "",
                author: 0,
                limit: 0
            },
            posts: []
        };
    },
    mounted: function() {
        this.updatePosts();
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
