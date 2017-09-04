<template>
  <div class="users-display">
      <vue-good-table
        title="Tutti gli utenti"
        :columns="columns"
        :rows="users"
        :paginate="true"
        :globalSearch="true"
        styleClass="mytable table condensed table-bordered table-striped" />
  </div>
</template>

<script>

//TODO still unused

function truncate(str, len){
  str = str || "";
  if(str.length > len){
    return str.substring(0, len) + " [...]"; 
  } else {
    return str;
  }
}

let UserPage = {
  props: {
    users: Array,
    skills: Array
  },
  data: function() {
    return {
      currentPost: null,
      columns: [
        {
          label: '',
          field: (x) => `<img src="${x.thumbnail}" class="avatar></img>`,
          html: true,
          filterable: false,
          width: "20%"
        }, {
          label: 'Nome',
          field: 'name',
          width: "20%"
        },
        {
          label: 'Occupazione',
          field: 'occupation',
          width: "20%"
        },
        {
          label: 'Skills',
          field: 'skills',
          tdClass: "content",
          width: "40%"
        }],
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
  }
};

export default UserPage;

</script>

<style>
.content {
  overflow-wrap: break-word;
}
.mytable {
  table-layout: fixed;
}
</style>
