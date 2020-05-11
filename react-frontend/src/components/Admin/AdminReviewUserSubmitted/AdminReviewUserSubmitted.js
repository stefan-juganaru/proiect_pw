import React from "react";
import './AdminReviewUserSubmitted.scss'
import axios from 'axios';

class AdminReviewUserSubmitted extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            'user_submitted': [],
            'batch_size': 15,
            'current_index': 0,
            usersubmitFlag: false
        };

        this.onActionButtonClick = this.onActionButtonClick.bind(this);
        this.getSubmittedQuestionsTable = this.getSubmittedQuestionsTable.bind(this);
        this.getSubmittedQuestionsNavigation = this.getSubmittedQuestionsNavigation.bind(this);
        this.getUserSubmitted = this.getUserSubmitted.bind(this);
        this.userSubmitQuestion = this.userSubmitQuestion.bind(this);
    }

    componentDidMount() {
        this.getUserSubmitted();
    }

    getUserSubmitted() {
        const options = {
            'headers': {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        };

        axios.get(
            'http://localhost:80/admin/user_submitted',
            options
        ).then((result) => {
            this.setState({
                'user_submitted': result.data
            });

            this.forceUpdate();
        }).catch((error) => {
            if ('response' in error) {
                console.log(error.response);
            } else {
                console.log(error);
            }
        });
    }

    onActionButtonClick(question_id, action, index) {
        const params = new URLSearchParams();

        params.append('question_id', question_id);
        params.append('action', action);

        const options = {
            'headers': {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        }

        axios.post(
            'http://localhost:80/admin/user_submitted',
            params,
            options
        ).then(() => {
            this.getUserSubmitted();
        }).catch((error) => {
            if ('response' in error) {
                console.log(error.response);
            } else {
                console.log(error);
            }
        })
    }

    getSubmittedQuestionsTable() {
        return (
            <table cellSpacing={'0'} cellPadding={'0'}>
                <thead>
                    <tr className={'TableHeader'}>
                        <th>Question ID</th>
                        <th>Username</th>
                        <th>User Question</th>
                        <th />
                        <th />
                        <th />
                    </tr>
                </thead>

                <tbody>
                    {
                        this.state.user_submitted.map((current, index) => {
                            if (this.state.current_index <= index &&
                                this.state.current_index + this.state.batch_size > index) {
                                return (

                                    <tr key={index}>
                                        <td>{current.QuestionID}</td>
                                        <td className={'Highlight'}>{current.Username}</td>
                                        <td>{current.Answer1}</td>
                                        <td>
                                            <button onClick={() => {
                                                this.onActionButtonClick(current.QuestionID, 1, index);
                                            }}>
                                                Approve
                                        </button>
                                        </td>
                                        <td>
                                            <button onClick={() => {
                                                this.onActionButtonClick(current.QuestionID, 2, index);
                                            }}>
                                                Report User
                                        </button>
                                        </td>
                                        <td>
                                            <button onClick={() => {
                                                this.onActionButtonClick(current.QuestionID, 3, index);
                                            }}>
                                                Delete
                                        </button>
                                        </td>
                                    </tr>
                                );
                            } else {
                                return <span />
                            }
                        }, this)
                    }
                </tbody>

            </table>
        );
    }

    getSubmittedQuestionsNavigation() {
        return (
            <div className={'TableNavigation'}>
                <button onClick={() => { this.setState({ 'current_index': 0 }); }}>
                    {'<<'}
                </button>
                <button onClick={() => {
                    this.setState({
                        'current_index': this.state.current_index > this.state.batch_size ?
                            this.state.current_index - this.state.batch_size :
                            0
                    });
                }}>
                    {'<'}
                </button>
                <span>
                    Page {
                        Math.round(this.state.current_index / this.state.batch_size) + 1
                    } of {
                        this.state.user_submitted.length === 0 ?
                            1 :
                            Math.ceil(this.state.user_submitted.length / this.state.batch_size)
                    }
                </span>
                <button onClick={() => {
                    this.setState({
                        'current_index':
                            this.state.current_index + this.state.batch_size < this.state.user_submitted.length ?
                                this.state.current_index + this.state.batch_size :
                                this.state.user_submitted.length > this.state.batch_size ?
                                    this.state.user_submitted.length - this.state.batch_size :
                                    0
                    });
                }}>
                    {'>'}
                </button>
                <button onClick={() => {
                    this.setState({
                        'current_index': this.state.user_submitted.length > this.state.batch_size ?
                            (Math.ceil(this.state.user_submitted.length / this.state.batch_size) - 1) *
                            this.state.batch_size :
                            0
                    });
                }}>
                    {'>>'}
                </button>
            </div>
        )
    }

    userSubmitQuestion() {

        this.setState({
            usersubmitFlag: !this.state.usersubmitFlag,
        })
    }
    render() {
        return (
            <div className={'AdminReviewUserSubmitted'}>
                <a href="#" className="usersubmitquestion" onClick={this.userSubmitQuestion}>Users' Questions</a>
                <br />
                <br />
                {this.state.usersubmitFlag ?
                    <div>
                        {
                            this.getSubmittedQuestionsTable()
                        }
                        {
                            this.getSubmittedQuestionsNavigation()
                        }
                    </div> : ''
                }
            </div>
        )
    }
}

export default AdminReviewUserSubmitted;