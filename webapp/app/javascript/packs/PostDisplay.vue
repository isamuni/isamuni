<template>
<div class="post-display">
    <div v-if="asList">
        <vue-good-table title="Post dalle community" :columns="columns" :rows="posts" :paginate="false" :globalSearch="true" :onClick="showModal" styleClass="mytable table condensed table-bordered table-striped" />
    </div>
    <div v-else>
        <PostCard v-for="p in posts" :post="p" :key="p.id" @click="showModal(p)"></PostCard>
    </div>
    <PostModal v-if="currentPost" :post="currentPost" ref="postModal"></PostModal>
</div>
</template>

<script>
/* global moment, Vue */

import PostCard from './PostCard.vue';
import PostModal from './PostModal.vue';

function truncate(str, len) {
    str = str || "";
    if (str.length > len) {
        return str.substring(0, len) + " [...]";
    } else {
        return str;
    }
}

let PostDisplay = {
    props: {
        posts: Array,
        asList: Boolean
    },
    data: function() {
        return {
            currentPost: null,
            columns: [{
                    label: 'Data',
                    field: (x) => moment(x.created_at).format("DD/MM/YYYY LT"),
                    width: "15%"
                },
                {
                    label: 'Autore',
                    field: 'author_name',
                    width: "15%"
                },
                {
                    label: 'Contenuto',
                    field: (x) => truncate([(x.name), (x.content)].filter(Boolean).join(" -- "), 200),
                    tdClass: "content",
                    width: "50%"
                },
                {
                    label: 'Fonte',
                    field: "source.name",
                    width: "20%"
                }
            ],
        };
    },
    methods: {
        showModal(post) {
            this.currentPost = post;
            Vue.nextTick(() => {
                this.$refs.postModal.show();
            });
        }
    },
    components: {
        PostCard,
        PostModal
    }
};

export default PostDisplay;
</script>

<style>
.content {
    overflow-wrap: break-word;
}

.mytable {
    table-layout: fixed;
}
</style>
