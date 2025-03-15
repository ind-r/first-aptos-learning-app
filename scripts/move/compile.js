require("dotenv").config();
const cli = require("@aptos-labs/ts-sdk/dist/common/cli/index.js");

async function compile() {
  const move = new cli.Move();

  await move.compile({
    packageDirectoryPath: "contract",
    namedAddresses: {
      // Compile module with account address
      todolist_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello2_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello3_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello4_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello5_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello6_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
      hello7_addr: process.env.NEXT_MODULE_PUBLISHER_ACCOUNT_ADDRESS,
    },
  });
}
compile();
