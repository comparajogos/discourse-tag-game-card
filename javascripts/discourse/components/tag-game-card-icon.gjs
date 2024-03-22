import dIcon from "discourse-common/helpers/d-icon";

<template>
  <div class="game-tag-card__info-item">
    {{dIcon @icon class="game-tag-card__icon"}}
    <span class="text--highlighted">
      {{@info}}
    </span>
  </div>
  <div class="game-tag-card__info-item-desc only-desktop">
    {{@text}}
  </div>
</template>
