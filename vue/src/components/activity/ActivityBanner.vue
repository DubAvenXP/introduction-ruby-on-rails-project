<template>
  <div class="banner">
    <img
      src="https://images.pexels.com/photos/939328/pexels-photo-939328.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
      alt=""
    />
    <div class="overlay">
      <h1>{{ title }}</h1>
    </div>
  </div>
</template>

<script>
import { defineComponent } from "vue";
export default defineComponent({
  name: "ActivityBanner",
  props: {
    title: {
      type: String,
      required: true,
    },
  },
});
</script>

<style lang="scss" scoped>
.banner {
  position: relative;
  height: 325px;
  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    h1 {
      color: #fff;
      font-size: 3rem;
      font-weight: bold;
      letter-spacing: 0.4rem;
      text-transform: uppercase;
    }
  }
}
</style>
