namespace asp.net
{
    public partial class student_tasks
    {
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.Label lblTotalQuizzes;
        protected global::System.Web.UI.WebControls.Label lblPassedQuizzes;
        protected global::System.Web.UI.WebControls.Label lblTotalTasks;
        protected global::System.Web.UI.WebControls.Label lblCompletedTasks;

        // Quizzes DataList & PlaceHolder
        protected global::System.Web.UI.WebControls.DataList rptStudentQuizzes;
        protected global::System.Web.UI.WebControls.PlaceHolder pnlNoQuizzes;

        // Project Tasks DataList & PlaceHolder
        protected global::System.Web.UI.WebControls.DataList rptStudentTasks;
        protected global::System.Web.UI.WebControls.PlaceHolder pnlNoTasks;

        // Hidden controls for quiz postback
        protected global::System.Web.UI.WebControls.HiddenField hfQuizAssignmentId;
        protected global::System.Web.UI.WebControls.HiddenField hfQuizScore;
        protected global::System.Web.UI.WebControls.HiddenField hfQuizCorrectCount;
        protected global::System.Web.UI.WebControls.HiddenField hfQuizTotalQuestions;
        protected global::System.Web.UI.WebControls.Button btnHiddenSubmitQuiz;
    }
}
