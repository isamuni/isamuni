<template>
  <div class="post-display">
    <PostCard v-for="p in posts" :post="p" @click="showModal(p)" ></PostCard>
    <PostModal v-if="currentPost" :post="currentPost" ref="postModal"></PostModal>
  </div>
</template>

<script>

import PostCard from './PostCard.vue';
import PostModal from './PostModal.vue';

let PostDisplay = {
	props: {
	  posts: Array
	},
	data: function () {
	  return { currentPost: null}
	},
	methods: {
	  showModal: function(post){
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
