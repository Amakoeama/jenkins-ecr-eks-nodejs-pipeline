const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({
    service: "Jenkins → ECR → EKS Pipeline",
    status: "running"
  });
});

app.get('/health', (req, res) => {
  res.status(200).send("healthy");
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
