"use strict";

const superSecret = process.env["SUPER_SECRET"];

module.exports.printSecrets = async function(context, req) {
  context.log(
    "JavaScript HTTP trigger function processed a request to display the secret in keyvault."
  );

  context.res = {
    // status: 200, /* Defaults to 200 */
    // FOR DEMO PURPOSE: DO NOT LOG SECRETS IN PRODUCTION
    body: `Shhhhh.. it's a secret: ${superSecret}`
  };
};
