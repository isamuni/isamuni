<template>
<div class="post-card card post" @click="$emit('click')" :style="style">
    <img v-if="post.picture" v-bind:src="post.picture" v-bind:alt="post.alt" class="card-img-top"></img>
    <div class="card-block">
        <p class="card-text" style="word-wrap: break-word;">{{ text }}</p>
    </div>
    <div class="card-footer text-muted text-right">
        {{author_name}} - {{ time }}
        <br> <img v-bind:src="post.source.icon_link" /> {{post.source.name}}
        <hr>
        <div class="row">
            <div class="col-xs-6 text-xs-left">
                {{post.likes}} <i class="fa fa-thumbs-up"></i> {{post.comments}} <i class="fa fa-comments"></i> {{post.shares}} <i class="fa fa-share-alt"></i>
            </div>
            <div class="col-xs-6 text-xs-right">
                <i :class="icon">
            </div>
        </div>
    </div>
</div>
</template>

<script>
/* global moment */

function postIcon(postType) {
    if (postType == 'link')
        return 'fa fa-link';
    if (postType == 'event')
        return 'fa fa-calendar';
    if (postType == 'photo')
        return "fa fa-photo";
    return "fa fa-sticky-note-o";
}

function postStyle(postType) {
    if (postType == 'link')
        return 'border-color: #FDD835;';
    if (postType == 'photo')
        return "border-color: #FFB300;";
    return "border-color: #AED581;";
}

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
        },
        icon: function() {
            return postIcon(this.post.post_type);
        },
        style: function() {
            return postStyle(this.post.post_type);
        }
    }
};

export default PostCard;
</script>

<style>
.post-card {
    width: 250px;
    display: inline-block;
    height: 400px;
    overflow: hidden;
    margin-right: 10px;
}

.post-card .card-footer {
    width: 100%;
    position: absolute;
    bottom: 0;
    font-size: 13px;
}

.post-card .card-img-top {
    width: 100%;
    height: 100px;
    object-fit: cover;
}
</style>
