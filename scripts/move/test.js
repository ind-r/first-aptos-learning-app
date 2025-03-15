require("dotenv").config();

const cli = require("@aptos-labs/ts-sdk/dist/common/cli/index.js");

async function test() {
  const move = new cli.Move();

  await move.test({
    packageDirectoryPath: "contract",
    namedAddresses: {
      todolist_addr: "0x100",
      hello_addr: "0x100",
      hello2_addr: "0x100",
      hello3_addr: "0x100",
      hello4_addr: "0x100",
      hello5_addr: "0x100",
      hello6_addr: "0x100",
      hello7_addr: "0x100",
    },
  });
}
test();
