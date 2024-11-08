package controller;

import dao.CandidateDao;
import dao.CompanyDao;
import dao.UserDao;
import model.Candidate;
import model.Company;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDao userDao=new UserDao();
        User loggedUser = userDao.loginUser(username, password);

        if(loggedUser!=null) {
            HttpSession session=request.getSession();
            session.setAttribute("user", loggedUser);



            //if logged in user is employer --> redirect to employer dashboard
            if (loggedUser.getRole().equals("Employer")) {

                CompanyDao companyDao = new CompanyDao();
                Company companyExist = companyDao.isCompanyExist(loggedUser.getUserId());

                if (companyExist != null) { //if user has a company, redirect to employer dashboard
                    response.sendRedirect(request.getContextPath() + "/employer/employer-dashboard");
                } else {  //if user does not have a company, redirect to add company page
                    response.sendRedirect(request.getContextPath() + "/employer/add_company.jsp");
                }
            }



            //if logged in user is candidate --> redirect to candidate dashboard
            else if (loggedUser.getRole().equals("JobSeeker")) {

                CandidateDao candidateDao = new CandidateDao();
                Candidate candidateExist = candidateDao.isCandidateExist(loggedUser.getUserId());

                if(candidateExist != null) { //if user has a candidate, redirect to candidate dashboard
                    response.sendRedirect(request.getContextPath() + "/candidate/candidate-dashboard");
                }
                else { //if user does not have a candidate, redirect to add candidate page
                    response.sendRedirect(request.getContextPath() + "/candidate/register_candidate.jsp");
                }
            }


        }

        else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
