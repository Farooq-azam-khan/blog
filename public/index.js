/** @typedef {{load: (Promise<unknown>); flags: (unknown)}} ElmPagesInit */
import "https://cdn.jsdelivr.net/npm/katex@0.16.0/dist/katex.min.js"
/** @type ElmPagesInit */
export default {
  load: async function (elmLoaded) {
    const app = await elmLoaded;
    console.log("App loaded", app);
  },
  flags: function () {
    return "You can decode this in Shared.elm using Json.Decode.string!";
  },
};
