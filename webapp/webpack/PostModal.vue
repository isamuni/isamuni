<template>
 <div id="post-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <i :class="icon"></i>
          <a :href="post.link" target="_blank">{{ time }}</a>
          <a v-if="post.author_link!=nil" :href="post.author_link">{{ post.author_name }}</a>
          <span v-else> {{ post.author_name }}</span> @ {{post.source.name}}
        </div>
        <div class="modal-body">
        {{post.content}}
        <p>
        <a :href="post.link" target="_blank">
          <img v-if="post.picture" :src="post.picture" :alt="post.alt" class="center-block img-fluid img-rounded"/>
        </a>
        </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

/* global moment, $ */

function postIcon(postType) {
  if (postType == 'link')
    return 'fa fa-link';
  if (postType == 'event')
    return 'fa fa-calendar';
  if (postType == 'photo')
    return "fa fa-photo";
  return "fa fa-sticky-note-o";
}

var PostModal = {
  props: {
    post: Object
  },
  computed: {
    icon: function() {
      return postIcon(this.post.post_type);
    },
    time: function() {
      return moment(this.post.created_at).format("L LT");
    }
  },
  methods: {
    show: function() {
      $(this.$el).modal('show');
    }
  }
};

export default PostModal;

</script>

<style>

.modal {
    overflow-y: auto;
}

.modal-open {
    overflow: auto;
}

.modal-open[style] {
    padding-right: 0px !important;
}

</style>
