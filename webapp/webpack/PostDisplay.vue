<template>
  <div class="post-display">
    <PostCard v-for="p in posts" :post="p" @click="selected(p)" ></PostCard>
    <PostModal v-if="currentPost" :post="currentPost" ref="postModal"></PostModal>
  </div>
</template>

<script>

import PostCard from './PostCard.vue';
import PostModal from './PostModal.vue';
/* Fetches and displays the posts
 * given some filters */
let PostDisplay = {
	props: {
	  filter: Object,
	  sources: Object
	},
	data: function () {
	  return { posts: [], currentPost: null}
	},
	mounted: function() {
	  this.getPosts(this.filter);
	},
	methods: {
	  getPosts: function(filter){
	    var that = this;
	    $.ajax({
	    url: '/feed/posts.json',
	    success: function(res) {    
	      res = res.map(function(a){a['source'] = that.sources[a['source_id']]; return a;});
	      that.posts = res;
	    }
	  });
	  },
	  selected: function(post){
	    this.currentPost = post;
	    var _this = this;
	    Vue.nextTick(function () {
	      _this.$refs.postModal.show();
	    });
	  }
	},
	components : { PostCard, PostModal }
}

export default PostDisplay;

</script>

<style>

</style>
