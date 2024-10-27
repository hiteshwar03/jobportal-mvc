<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<%@ page import="dao.*, model.*, java.util.*" %>

<%
    HttpSession session1 = request.getSession();
    User user = (User) session1.getAttribute("user");

    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getJobsByUserId(user.getUserId());

    request.setAttribute("jobs", jobs);

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard</title>
    <link rel="stylesheet" href="../css/style.css">
    <%@ include file="../components/header.jsp"%>
    <style>
        body {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

    <main>

       <%@ include file="employer_navbar.jsp"%>

        <div class="content view-applications">
            <div class="header">
                <h4>Welcome, <span style="font-weight: bold">${sessionScope.user.username}</span></h4>
            </div>


            <div class="main-content">
                <h4 class="title">Your Job Postings</h4>
                <!-- Job Postings Section -->
                <section>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr class="bg-dark text-white">
                                                <th>Job Title</th>
                                                <th>Location</th>
                                                <th>Date Posted</th>
                                                <th>Last Date</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                          <c:forEach items="${jobs}" var="job">
                                              <tr>
                                                  <td>${job.jobTitle}</td>
                                                  <td>${job.jobLocation}</td>
                                                  <td><fmt:formatDate value="${job.createdAt}" pattern="dd-MM-yyyy" /></td>
                                                  <td><fmt:formatDate value="${job.lastDate}" pattern="dd-MM-yyyy" /></td>
                                                  <td>${job.jobStatus}</td>
                                                  <td>
                                                       <a href="view-job-details?id=${job.jobId}" class="btn btn-info btn-sm">View</a>
                                                       <a href="#" class="btn btn-primary btn-sm">Edit</a>
                                                       <a href="#" class="btn btn-danger btn-sm">Delete</a>
                                                   </td>
                                              </tr>
                                          </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
   	</main>
</body>
</html>
