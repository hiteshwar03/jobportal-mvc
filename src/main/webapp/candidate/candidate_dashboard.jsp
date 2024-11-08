<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<%@ page import="dao.*, model.*, java.util.* " %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Portal: Candidate Dashboard</title>
    <%@ include file="../components/header.jsp"%>
    <%@ include file="../components/custom_toast.html"%>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        #btn-edit-profile{
            padding: 8px 10px;
            font-size: 12px;
            background-color: green;
            border-radius: 0px;
            margin-right: 10px;
            color: white;
        }
        #btn-logout{
            background-color: crimson;
            padding: 8px 10px;
            font-size: 12px;
            color: white;
        }
        .profile-img{
            width: 100px;
            height: 100px;
            border-radius: 50%;
            position: relative;
            left: 34%;
            gap: 10px;
        }
        .badge{
            display: inline-block;
            width: 50px;
            padding: 8px 5px;
            margin: 0 auto;
        }
        .job-filters a{
            display: inline-block;
            background: #35424a;
            color: white;
            border: none;
            padding: 6px 15px;
            cursor: pointer;
            margin-left: 10px;
            border-radius: 50px;
            font-size: 12px;
        }
    </style>
</head>
<body>

    <%@ include file="../components/navbar.jsp"%>

    <div class="container candidate-dashboard2">
        <div class="content">

            <c:if test="${not empty error}">
                <script>
                    showToast("${error}");
                </script>
            </c:if>

            <c:if test="${not empty success}">
                <script>
                    showToast("${success}");
                </script>
            </c:if>


            <section id="profile">
                <div class="profile-card">
                    <div class="profile-img">
                        <img src="${pageContext.request.contextPath}/images/users/${sessionScope.user.pic}" alt="User Avatar" class="avatar">
                    </div>
                    <div class="profile-info">
                        <h3>${candidate.name}</h3>
                        <p><strong>Username:</strong>: ${sessionScope.user.username}</p>
                        <p><strong>Email:</strong>: ${sessionScope.user.email}</p>
                        <p><strong>Address:</strong>:${candidate.address} </p>
                        <p><strong>Skills:</strong>: ${candidate.skills}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/candidate/candidate-profile" id="btn-edit-profile">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" id="btn-logout">Logout <i class="fas fa-sign-out-alt"></i></a>
                </div>
            </section>


            <section id="job-listings">

                <form action="${pageContext.request.contextPath}/candidate/search-jobs" method="post">
                    <input type="text" placeholder="Enter skill / company / designation..." id="job-search"  name="keyword">
                    <select id="job-type" name="jobType">
                        <option value="">-Select Job Type-</option>
                        <option value="Full Time">Full Time</option>
                        <option value="Part Time">Part Time</option>
                        <option value="Internship">Internship</option>
                        <option value="Contract">Contract</option>
                        <option value="Remote">Remote</option>
                    </select>
                    <select id="job-location" name="jobLocation">
                        <option value="">-Select Job Location-</option>
                        <option value="Noida">Noida</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Gurugram">Gurugram</option>
                        <option value="Faridabad">Faridabad</option>
                        <option value="Ghaziabad">Ghaziabad</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Pune">Pune</option>
                        <option value="Chennai">Chennai</option>
                        <option value="Bangalore">Bangalore</option>
                        <option value="Hyderabad">Hyderabad</option>
                        <option value="Kolkata">Kolkata</option>
                        <option value="Ahmedabad">Ahmedabad</option>
                        <option value="Surat">Surat</option>
                        <option value="Jaipur">Jaipur</option>
                        <option value="Lucknow">Lucknow</option>
                    </select>
                    <select name="experience" id="experience" name="experience">
                        <option value="">-Select Experience-</option>
                        <option value="0">Fresher</option>
                        <option value="1">1 Year</option>
                        <option value="2">2 Years</option>
                        <option value="3">3 Years</option>
                        <option value="4">4 Years</option>
                        <option value="5">5 Years</option>
                        <option value="6">6 Years</option>
                        <option value="7">7 Years</option>
                        <option value="8">8 Years</option>
                     </select>
                     <input type="submit" value="Search" class="search-btn btn btn-primary" id="btn-search">
                </form>

                <div class="job-filters">
                    <a href="candidate-dashboard" class="text-white bg-primary">All</a>
                    <a href="recent-jobs" class="text-white bg-primary">Recent</a>
                </div>


                <div class="job-list" id="job-list">
                   <c:forEach items="${jobs}" var="job">
                       <c:if test="${job.jobStatus == 'Open'}">
                            <div class="job-card" data-type="Software Engineer">
                               <div class="job-details">
                                   <h3>${job.jobTitle}</h3>
                                   <p class="text-success">Last Date:  <span class="postedDate"><fmt:formatDate value="${job.lastDate}" pattern="dd-MM-yyyy" /></span></p>
                               </div>
                               <p>Company: ${job.company.companyName}</p>
                               <p>Location: ${job.jobLocation}</p>
                               <a href="${pageContext.request.contextPath}/candidate/view-job?jobId=${job.jobId}" id="btn-apply" >View Details</a>
                           </div>
                       </c:if>
                   </c:forEach>

                </div>
            </section>
        </div>
    </div>

      <%@ include file="../components/footer.jsp"%>

    <script>


        function applyForJob(jobTitle) {
            if (confirm(`Are you sure you want to apply for ${jobTitle}?`)) {
                alert('Application submitted!');
            }
        }
    </script>
</body>
</html>
