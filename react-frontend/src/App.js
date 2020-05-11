import React from 'react';
import './App.scss';
import { HashRouter, BrowserRouter, Redirect, Route } from 'react-router-dom';
import Header from "./components/Header";
import VotePage from "./components/VotePage";
import FAQPage from "./components/FAQPage";
import ContactPage from "./components/ContactPage";
import AdminPage from "./components/Admin/AdminPage";
import SupportPage from "./components/SupportPage";

class App extends React.Component {

    constructor(props) {
        super(props);

        const consent = localStorage.getItem('consent');

        if (!consent) {
            alert('This website uses cookies');

            localStorage.setItem('consent', 'true');
        }

        this.state = {
            LoginStatus: false
        }

        this.forceUpdate = this.forceUpdate.bind(this);
    }

    forceUpdate() {

        // let result = window.confirm("Press a button!");
        // if (result) {
        //     window.alert("true")
        // } else {
        //     window.alert("false")
        // }
    }
    render() {

        // console.log("render app here")
        return (
            <HashRouter>
                <div className='App'>
                    <Header refresh={this.forceUpdate} changeLoginStatus={() => { this.setState({ LoginStatus: !this.state.LoginStatus }) }} />
                    <hr />
                    <div>
                        {
                            localStorage.getItem('role') === '1' ?
                                <Redirect to={'/admin'} /> :
                                localStorage.getItem('role') === '2' ?
                                    <Redirect to={'/support'} /> :
                                    <span />
                        }
                        <Route path={'/admin'} component={AdminPage} />
                        <Route path={'/support'} component={SupportPage} />
                        <Route exact path={'/'} component={VotePage} />
                        <Route path={'/confirmation/:id'} component={VotePage} />
                        <Route path={'/faq'} component={FAQPage} />
                        <Route path={'/contact'} component={ContactPage} />
                    </div>
                </div>
            </HashRouter>
        );
    }
}

export default App;