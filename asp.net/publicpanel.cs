using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public class publicpanel
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public SqlConnection getcon()
        {
            con = new SqlConnection(s);
            con.Open();
            return con;
        }

        //companies page
        // fill datalist method
        public DataSet select()
        {
            getcon();
            da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.CompanyId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search by company name or industry -- search filter
        public DataSet search(string nm)
        {
            getcon();
            da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and (c.c_company like '" + nm + "%' or c.c_industry like '" + nm + "%') order by c.CompanyId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select by city / location  -- dropdown list city filter
        public DataSet selectbycity(string ct)
        {
            getcon();
            if (ct == "")
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.CompanyId desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and c.c_location = '" + ct + "' order by c.CompanyId desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select by industry -- dropdown list industry filter
        public DataSet selectbyindustry(string ind)
        {
            getcon();
            if (ind == "")
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.CompanyId desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and c.c_industry = '" + ind + "' order by c.CompanyId desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select by size -- dropdown list size filter
        public DataSet selectbysize(string sz)
        {
            getcon();
            if (sz == "")
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.CompanyId desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and c.c_size = '" + sz + "' order by c.CompanyId desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Sort companies -- dropdown list sort filter
        public DataSet sortby(string s)
        {
            getcon();
            if (s == "name-asc")
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.c_company asc", con);
            }
            else if (s == "name-desc")
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.c_company desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.CompanyId desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        //internship page
        // fill internship datalist method
        public DataSet select_internship()
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search internships by keyword/title/company/domain -- serch filter
        public DataSet search_internship(string nm)
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and (i.InternshipTitle like '%" + nm + "%' or c.c_company like '%" + nm + "%' or i.InternshipDomain like '%" + nm + "%') order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select internships by category / domain -- dropdown list
        public DataSet select_internship_by_category(string cat)
        {
            getcon();
            if (cat == "")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and i.InternshipDomain = '" + cat + "' order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select internships by city / location -- dropdown list
        public DataSet select_internship_by_city(string ct)
        {
            getcon();
            if (ct == "")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and i.Location = '" + ct + "' order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select internships by duration -- dropdown list
        public DataSet select_internship_by_duration(string dur)
        {
            getcon();
            if (dur == "")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and i.Duration = '" + dur + "' order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Sort internships by stipend -- dropdown list
        public DataSet sort_internship(string s)
        {
            getcon();
            if (s == "stipend-desc")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by TRY_CAST(i.StipendAmount AS INT) desc, i.Id desc", con);
            }
            else if (s == "stipend-asc")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by TRY_CAST(i.StipendAmount AS INT) asc, i.Id desc", con);
            }
            else if (s == "duration-asc")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Duration asc, i.Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        //pagination for companies
        public DataTable pagination(DataTable dt, int page)
        {
            DataTable dt1 = dt.Clone();
            int start = page * 4;
            for (int i = start; i < start + 4 && i < dt.Rows.Count; i++)
            {
                dt1.ImportRow(dt.Rows[i]);
            }
            return dt1;
        }

        //pagination for internships
        public DataTable Internship_pagination(DataTable dt, int page)
        {
            DataTable dt1 = dt.Clone();
            int start = page * 12;
            for (int i = start; i < start + 12 && i < dt.Rows.Count; i++)
            {
                dt1.ImportRow(dt.Rows[i]);
            }
            return dt1;
        }
    }
}
