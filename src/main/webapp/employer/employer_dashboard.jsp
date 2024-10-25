<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page import="dao.*, model.*, java.util.* " %>

<%
    HttpSession session1 = request.getSession();
    User user = (User) session1.getAttribute("user");

    JobDao jobDao = new JobDao();
    List<Job> jobs = jobDao.getJobsByUserId(user.getUserId());
    List<Job> activeJobs = jobDao.getActiveJobsByUserId(user.getUserId());
    List<Job> closedJobs = jobDao.getClosedJobsByUserId(user.getUserId());


    request.setAttribute("jobs", jobs);
    request.setAttribute("activeJobs", activeJobs);
    request.setAttribute("closedJobs", closedJobs);

    ApplicationDao applicationDao = new ApplicationDao();
    List<Application> applications = applicationDao.getAllApplications();
    request.setAttribute("applications", applications);

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

        <div class="content employer-dashboard">
            <div class="header">
                <h4>Welcome, <span style="font-weight: bold">${sessionScope.user.username}</span></h4>
            </div>

            <div class="main-content">
                 <!-- Job Statistics Section -->
                            <section class="job-stats-section">
                                <h3>Job Statistics</h3>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card stat-card">
                                            <div class="card-header">
                                                <h5>Total Jobs Posted</h5>
                                            </div>
                                            <div class="card-body">
                                                <i class="fas fa-briefcase"></i>
                                                <h2>${jobs.size()}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card stat-card">
                                            <div class="card-header">
                                                <h5>Active Jobs</h5>
                                            </div>
                                            <div class="card-body">
                                                <i class="fas fa-check-circle"></i>
                                                <h2>${activeJobs.size()}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card stat-card">
                                            <div class="card-header">
                                                <h5>Closed Jobs</h5>
                                            </div>
                                            <div class="card-body">
                                                <i class="fas fa-times-circle"></i>
                                                <h2>${closedJobs.size()}</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- Application Statistics Section -->
                            <section class="application-stats-section">
                                <h3>Application Statistics</h3>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card stat-card">
                                            <div class="card-header">
                                                <h5>Total Applications</h5>
                                            </div>
                                            <div class="card-body">
                                                <i class="fas fa-file-alt"></i>
                                                <h2>[Total Applications]</h2>
                                            </div>
                                        </div>
                                    </div>

                                  <div class="col-md-4">
                                      <div class="card stat-card">
                                          <div class="card-header">
                                              <h5>Total Accepted Applications</h5>
                                          </div>
                                          <div class="card-body">
                                              <i class="fas fa-check-circle"></i>
                                              <h2>[Total Accepted]</h2>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <div class="card stat-card">
                                          <div class="card-header">
                                              <h5>Total Rejected Applications</h5>
                                          </div>
                                          <div class="card-body">
                                              <i class="fas fa-times-circle"></i>
                                              <h2>[Total Rejected]</h2>
                                          </div>
                                      </div>
                                  </div>

                                </div>

                            </section>

                            <!-- Job Postings Section -->
                            <section>
                                <h3>Your Job Postings</h3>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <table class="table table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th>Job Title</th>
                                                            <th>Location</th>
                                                            <th>Date Posted</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                      <c:forEach items="${jobs}" var="job">
                                                          <tr>
                                                              <td>${job.jobTitle}</td>
                                                              <td>${job.jobLocation}</td>
                                                              <td>${job.createdAt}</td>
                                                              <td>${job.jobStatus}</td>
                                                              <td>
                                                                   <a href="view_job.jsp?id=${job.jobId}" class="btn btn-info btn-sm">View</a>
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


                            <!-- application Section -->
                            <section>
                                <h3>All Applications</h3>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Application Id</th>
                                                            <th>Applied date</th>
                                                            <th>Candidate Name</th>
                                                            <th>Candidate Address</th>
                                                            <th>Job Title</th>
                                                            <th>Job Location</th>
                                                            <th>Application Status</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${applications}" var="application">
                                                            <tr>
                                                                <td>${application.applicationId}</td>
                                                                <td>${application.appliedDate}</td>
                                                                <td>${application.candidate.name}</td>
                                                                <td>${application.candidate.address}</td>
                                                                <td>${application.job.jobTitle}</td>
                                                                <td>${application.job.jobLocation}</td>
                                                                <td>${application.status}</td>
                                                                <td>
                                                                   <a href="view_job.jsp?id=${job.jobId}" class="btn btn-info btn-sm">View</a>
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

                            <!-- Company Information Section -->
                            <section>
                                <h3>Company Information</h3>
                                <div class="card company-card">
                                    <div class="card-body">
                                        <img src="../images/company/${company.logo}" alt="Company Logo" class="img-thumbnail" style="width: 100px; height: 100px; border-radius: 50%;">
                                        <p>Founded On: <span>${company.foundedYear}</span></p>
                                        <p>Company Name: <span>${company.companyName}</span></p>
                                        <p>Location: <span>${company.companyAddress}</span></p>
                                        <p>Website: <span>${company.companyWebsite}</span></p>
                                        <p>Company size: <span>${company.companySize}</span></p>
                                        <p>Company Email: <span>${company.companyEmail}</span></p>
                                        <a href="company_profile.jsp" class="btn btn-primary">Edit Company Profile</a>
                                    </div>
                                </div>
                            </section>

            </div>
        </div>
   	</main>
</body>
</html>
