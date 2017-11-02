import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Jumbotron from "./components/Jumbotron";

const App = () =>
  <Router>
    <div>
      <Switch>
        <Route exact path="/" component={Jumbotron} />
      </Switch>
    </div>
  </Router>;

export default App;
