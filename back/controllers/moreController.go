package controllers

import (
	"webprj/models"

	"github.com/gin-gonic/gin"
)

func GetContactUs(c *gin.Context) {
	fields := []models.ContactUs{
		{"Email", "support@web.com"},
		{"Phone", "+98 22334455"},
		{"twitter", "twitter.com/web_programming"},
		{"instagram", "instagram.com/web_programming"},
		{"address", "tehran, azadi, sharif university of technology"},
	}
	SendOK(c, &gin.H{"fields": fields})
}

func GetAboutUs(c *gin.Context) {
	fields := []models.AboutUs{
		{"A better way of working remotely", "In response, the two friends created a new web-based platform that brought visibility and trust to remote work. It was so successful the two realized other businesses would also benefit from reliable access to a larger pool of proven talent, while workers would enjoy freedom and flexibility to find jobs online. Together they decided to start a company that would deliver on the promise of this technology. Fast-forward to today, that technology is the foundation of Upwork — the leading flexible talent solution."},
		{"A world of opportunities", "Through Upwork, businesses get more done, connecting with proven professionals to work on projects from web and mobile app development to SEO, social media marketing, content writing, graphic design, admin help and thousands of other projects. Upwork makes it fast, simple, and cost-effective to find, hire, work with, and pay the best professionals anywhere, any time."},
		{"Developers", "Mohsen Kasiri, Mohammadjavad Mirteymori, Mahdi Farzadi"},
	}
	SendOK(c, &gin.H{"fields": fields})
}

func GetRules(c *gin.Context) {
	fields := []models.Rules{
		{"Information We Collect", "When you register to the Site, use it, complete forms, or register to our affiliate or influencer or similar program, we collect the personal information provided by you. We also collect information about your communications with us as well our communication with other users of this site. In addition, we collect information while you access, browse, view or otherwise use the Site."},
		{"How Do We Use the Information Collected?", "We use personal information to provide you with quality service and security, to operate the Site and to perform our obligations to you; to ensure marketplace integrity and security; to prevent fraud; to contact you and send you direct marketing communications; to promote and advertise the Site and our marketplace; to comply with lawful requests by public authorities and to comply with applicable laws and regulations. "},
		{"Children Under the Age of 13", "Our Site is not intended for children under 13 years of age and we do not knowingly collect personal information from children under 13. "},
		{"Cookies", "We use cookies and similar technologies (such as web beacons, pixels, tags, and scripts) to improve and personalize your experience, provide our services, analyze website performance and for marketing purposes."},
		{"Security", "We take great care in maintaining the security of the Site and your information and in preventing unauthorized access, loss, misuse, alteration, destruction or damage to it through industry standard technologies and internal procedures."},
	}
	SendOK(c, &gin.H{"fields": fields})
}
