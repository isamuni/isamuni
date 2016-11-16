<template>
  <div class="card post" @click="$emit('click')">
    <img v-if="post.picture"
         v-bind:src="post.picture" 
         v-bind:alt="post.alt"
         class="card-img-top"></img>
    <div class="card-block">
      <p class="card-text" style="word-wrap: break-word;">{{ text }}</p>
    </div>
    <div class="card-footer text-muted text-right">
      {{author_name}} - {{ time }} - 
      {{post.source.name}} <img v-bind:src="post.source.icon_link" />
    </div>
  </div>
</template>

<script>

/* global moment */

let PostCard = {
  props: {
    post: Object
  },
  computed: {
    text: function() {
      var content = this.post.content || "";
      var name = this.post.name ? this.post.name + " - " : "";
      return name + content;
    },
    time: function() {
      return moment(this.post.created_at).format("L LT");
    },
    author_name: function() {
      var name = this.post.author_name.split(" ");
      var first_name = name.shift();
      return first_name[0] + ". " + name.join(" ");
    }
  }
};

export default PostCard;

</script>

<style>

.card {
  width: 250px;
  display: inline-block;
  height: 400px;
  overflow: hidden;
  margin-right: 10px;
}

.card-footer {
  height: 80px;
  width:100%;
  position:absolute;
  bottom:0;
  font-size: 13px;
}

.card-img-top{
   width:100%;
   height:100px;
   object-fit: cover;
}

</style>
