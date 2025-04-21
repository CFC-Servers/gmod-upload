# gmod-upload

This is an action to upload a Garry's Mod addon to the steam workshop.

## Examples

### Example 1
This call only provides the `id` and `changelog`, and expects there to be an `addon.json` in the root of the project that runs it.
_Taken from https://github.com/Vurv78/WebAudio/blob/main/.github/workflows/deploy.yml_

```yaml
name: Deploy to Workshop

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          path: project
      - name: Upload to Workshop
        uses: CFC-Servers/gmod-upload@master
        with:
          id: 2466875474
          changelog: "Deployment via Github to latest changes"
        env:
          STEAM_USERNAME: ${{ secrets.STEAM_USERNAME }}
          STEAM_PASSWORD: ${{ secrets.STEAM_PASSWORD }}
```

### Example 2
This call provides the `id` and `changelog`, but also defines a nonstandard path to find the `addon.json`.
In this case, there must be a file named `different.json` in the root of the project that calls this workflow.

```yaml
name: Deploy to Workshop

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          path: project
      - name: Upload to Workshop
        uses: CFC-Servers/gmod-upload@master
        with:
          id: 2466875474
          changelog: "Deployment via Github to latest changes"
          config: "different.json"
        env:
          STEAM_USERNAME: ${{ secrets.STEAM_USERNAME }}
          STEAM_PASSWORD: ${{ secrets.STEAM_PASSWORD }}
```

### Example 3
This call provides all of the information inline, eliminating the need for an `addon.json`
```yaml
name: Deploy to Workshop

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          path: project
      - name: Upload to Workshop
        uses: CFC-Servers/gmod-upload@master
        with:
          id: 2466875474
          changelog: "Deployment via Github to latest changes"
          title: "[E2] WebAudio"
          type: "tool"
          tag1: "build"
          tag2: "fun"
          tag3: "realism"
        env:
          STEAM_USERNAME: ${{ secrets.STEAM_USERNAME }}
          STEAM_PASSWORD: ${{ secrets.STEAM_PASSWORD }}
```

---

<details>
<summary><h2>Workflow inputs</h2></summary>
<br>

| **Name**    | **Example**                              | **Notes**                                                                                                                                                                                                                                                                                     |
|-------------|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `changelog` | Created a new thing and fixed some stuff | The changelog to display in the Workhop's Updates section. Uses standard [Steam BBCode](https://steamcommunity.com/comment/ForumTopic/formattinghelp)                                                                                                                                         |
| `id`        | `2466875474`                             | The ID of the (already created) Workshop item                                                                                                                                                                                                                                                 |
| `config`    | `myaddon.json`                           | If present, will attempt to use the given path as the [addon.json](https://wiki.facepunch.com/gmod/Workshop_Addon_Creation#addonjson). If given, all of the following inputs are ignored. If no additional inputs are provided, a standard `addon.json` is expected to exist in your project. |
| `title`     | My glorious addon                        | The title of the Workshop item.<br><br>:warning: This input will be ignored if the `config` input is used                                                                                                                                                                                     |
| `type`      | ServerContent                            | The addon type. Must be one of:<br>```ServerContent, gamemode, map, weapon, vehicle, npc, tool, effects, model, entity```<br><br>:warning: This input will be ignored if the `config` input is used.                                                                                          |
| `tag1`      | fun                                      | The first tag. Must be one of:<br>```fun, roleplay, scenic, movie, realism, cartoon, water, comic, build```<br><br>:warning: This input will be ignored if the `config` input is used.                                                                                                        |
| `tag2`      | roleplay                                 | The second tag (Optional). Must be one of:<br>```fun, roleplay, scenic, movie, realism, cartoon, water, comic, build```<br><br>:warning: This input will be ignored if the `config` input is used.                                                                                            |
| `tag3`      | realism                                  | The third tag (Optional). Must be one of:<br>```fun, roleplay, scenic, movie, realism, cartoon, water, comic, build```<br><br>:warning: This input will be ignored if the `config` input is used.                                                                                             |
| `remove_lua`  | true                                     | If set to `true`, will the remove the `lua` folder from the uploaded files. default is `false` |

</details>
