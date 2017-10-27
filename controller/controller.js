const express = require('express');
const router = express.Router();

router.get("/", (request, response)=>{
    console.log("Home Rendered");
})

module.exports = router