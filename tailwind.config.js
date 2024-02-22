/** @type {import('tailwindcss').Config} */

/* eslint-disable @typescript-eslint/no-var-requires */
const defaultTheme = require("tailwindcss/defaultTheme")
const colors = require("tailwindcss/colors")
const { blackA, mauve, violet } = require("@radix-ui/colors")

module.exports = {
  content: ["javascript/**/*.{gjs,gts,hbs,html,js,ts}"],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        // TODO remove this override
        blue: colors.sky,

        // radix
        ...blackA,
        ...mauve,
        ...violet,
      },
      boxShadow: {
        // TODO refactor these styles
        outline: "0 0 0 2px rgba(66, 153, 225, 0.7)",
        error: "0 0 0 1px rgba(255, 153, 150, 0.5)",
      },
      fontFamily: {
        sans: ["Montserrat", ...defaultTheme.fontFamily.sans],
      },

      keyframes: {
        fadeIn: {
          from: { opacity: 0 },
          to: { opacity: 1 },
        },

        // dropdown-menu
        slideDownAndFade: {
          from: { opacity: 0, transform: "translateY(-2px)" },
          to: { opacity: 1, transform: "translateY(0)" },
        },
        slideLeftAndFade: {
          from: { opacity: 0, transform: "translateX(2px)" },
          to: { opacity: 1, transform: "translateX(0)" },
        },
        slideUpAndFade: {
          from: { opacity: 0, transform: "translateY(2px)" },
          to: { opacity: 1, transform: "translateY(0)" },
        },
        slideRightAndFade: {
          from: { opacity: 0, transform: "translateX(-2px)" },
          to: { opacity: 1, transform: "translateX(0)" },
        },
        // dialog
        overlayShow: {
          from: { opacity: 0 },
          to: { opacity: 1 },
        },
        contentShow: {
          from: { opacity: 0, transform: "translate(-50%, -46%) scale(0.96)" },
          to: { opacity: 1, transform: "translate(-50%, -50%) scale(1)" },
        },
        contentShowMobile: {
          from: { opacity: 0, transform: "translate(-50%, 5%) scale(0.98)" },
          to: { opacity: 1, transform: "translate(-50%, 0%) scale(1)" },
        },
      },
      animation: {
        fadeIn: "fadeIn 400ms cubic-bezier(0.16, 1, 0.3, 1)",
        // dropdown-menu
        slideDownAndFade:
          "slideDownAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)",
        slideLeftAndFade:
          "slideLeftAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)",
        slideUpAndFade: "slideUpAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)",
        slideRightAndFade:
          "slideRightAndFade 400ms cubic-bezier(0.16, 1, 0.3, 1)",
        // dialog
        overlayShow: "overlayShow 200ms cubic-bezier(0.16, 1, 0.3, 1)",
        contentShow: "contentShow 200ms cubic-bezier(0.16, 1, 0.3, 1)",
        contentShowMobile:
          "contentShowMobile 200ms cubic-bezier(0.16, 1, 0.3, 1)",
      },
    },
  },  plugins: [],
}

