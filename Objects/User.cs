using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Charity.Objects
{
  public class User
  {
    public static User CurrentUser;

    public int Id {get; set;}
    public int RoleId {get; set;}
    public string Name {get; set;}
    public string Login {get; set;}
    public string Password {get; set;}
    public ContactInformation ContactInfo {get; set;}

    public User()
    {
      Name = null;
      Login = null;
      Password = null;
      ContactInfo = null;
      RoleId = 0;
      Id = 0;
    }

    public User(string name, string login, string password, ContactInformation contactInfo, int roleId = 1, int id = 0)
    {
      Name = name;
      Login = login;
      Password = password;
      ContactInfo = contactInfo;
      RoleId = roleId;
      Id = id;
    }
    //
    // public static User GetCurrentUser()
    // {
    //   return CurrentUser;
    // }

    public override bool Equals(System.Object otherUser)
    {
      if (!(otherUser is User))
      {
        return false;
      }
      else
      {
        User newUser = (User)otherUser;
        return (this.Id == newUser.Id &&
                this.RoleId == newUser.RoleId &&
                this.Name == newUser.Name &&
                this.Login == newUser.Login &&
                this.Password == newUser.Password &&
                this.ContactInfo.Equals(newUser.ContactInfo));
      }
    }

    public static List<User> GetAll()
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("SELECT * FROM users;", DB.GetConnection());
      SqlDataReader rdr = cmd.ExecuteReader();

      List<User> users = new List<User>{};
      while (rdr.Read())
      {
        int id = rdr.GetInt32(0);
        int roleId = rdr.GetInt32(1);
        string name = rdr.GetString(2);
        string login = rdr.GetString(3);
        string password = rdr.GetString(4);
        string address = rdr.GetString(5);
        string phoneNumber = rdr.GetString(6);
        string email = rdr.GetString(7);

        ContactInformation info = new ContactInformation(address, phoneNumber, email);
        User user = new User(name, login, password, info, roleId, id);
        users.Add(user);
      }

      if (rdr != null)
      {
        rdr.Close();
      }
      DB.CloseConnection();

      return users;
    }

    public void Save()
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("INSERT INTO users (role_id, name, login, password, address, phone_number, email) OUTPUT INSERTED.id VALUES (@RoleId, @Name, @Login, @Password, @Address, @PhoneNumber, @Email)", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@RoleId", this.RoleId));
      cmd.Parameters.Add(new SqlParameter("@Name", this.Name));
      cmd.Parameters.Add(new SqlParameter("@Login", this.Login));
      cmd.Parameters.Add(new SqlParameter("@Password", this.Password));
      cmd.Parameters.Add(new SqlParameter("@Address", this.ContactInfo.Address));
      cmd.Parameters.Add(new SqlParameter("@PhoneNumber", this.ContactInfo.PhoneNumber));
      cmd.Parameters.Add(new SqlParameter("@Email", this.ContactInfo.Email));

      SqlDataReader rdr = cmd.ExecuteReader();
      while (rdr.Read())
      {
        this.Id = rdr.GetInt32(0);
      }
      DB.CloseConnection();
    }

    public static User ValiateUser(string inputLogin, string inputPassword)
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("SELECT * FROM users WHERE login = @Login AND password = @Password;", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@Login", inputLogin));
      cmd.Parameters.Add(new SqlParameter("@Password", inputPassword));

      SqlDataReader rdr = cmd.ExecuteReader();
      User result = null;

      while (rdr.Read())
      {
        int id = rdr.GetInt32(0);
        int roleId = rdr.GetInt32(1);
        string name = rdr.GetString(2);
        string login = rdr.GetString(3);
        string password = rdr.GetString(4);
        string address = rdr.GetString(5);
        string phoneNumber = rdr.GetString(6);
        string email = rdr.GetString(7);

        ContactInformation info = new ContactInformation(address, phoneNumber, email);
        result = new User(name, login, password, info, roleId, id);
      }
      return result;
    }

    public static User Find(int searchId)
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("SELECT * FROM users WHERE id = @UserId;", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@UserId", searchId));

      SqlDataReader rdr = cmd.ExecuteReader();

      User foundUser = new User();
      while (rdr.Read())
      {
        ContactInformation info = new ContactInformation();
        foundUser.Id = rdr.GetInt32(0);
        foundUser.RoleId = rdr.GetInt32(1);
        foundUser.Name = rdr.GetString(2);
        foundUser.Login = rdr.GetString(3);
        foundUser.Password = rdr.GetString(4);

        info.Address = rdr.GetString(5);
        info.PhoneNumber = rdr.GetString(6);
        info.Email = rdr.GetString(7);
        foundUser.ContactInfo = info;
      }

      if (rdr != null)
      {
        rdr.Close();
      }
      DB.CloseConnection();

      return foundUser;
    }

    public List<Dictionary<string,object>> GetDonationsByUser()
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("SELECT campaigns.name, donations.donation_amount, donations.donation_date FROM users JOIN donations ON (users.id = donations.user_id) JOIN campaigns ON (campaigns.id = donations.campaign_id) WHERE user_id = @UserId;", DB.GetConnection());
      cmd.Parameters.Add(new SqlParameter("@UserId", this.Id));

      SqlDataReader rdr = cmd.ExecuteReader();

      List<Dictionary<string,object>> allDonations = new List<Dictionary<string,object>>{};
      while(rdr.Read())
      {
        string name = rdr.GetString(0);
        int donationAmount = rdr.GetInt32(1);
        DateTime donationDate = rdr.GetDateTime(2);

        Dictionary<string, object> donationsInfo = new Dictionary<string, object> {};
        donationsInfo.Add("name", name);
        donationsInfo.Add("donationAmount", donationAmount);
        donationsInfo.Add("donationDate", donationDate.ToString("d"));
        allDonations.Add(donationsInfo);
      }

      if (rdr != null)
      {
        rdr.Close();
      }
      DB.CloseConnection();
      return allDonations;
    }

    public Donation MakeDonation(Campaign donatedCampaign, int donationAmount, DateTime date)
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("INSERT INTO donations (user_id, campaign_id, donation_amount, donation_date) OUTPUT INSERTED.id VALUES (@UserId, @CampaignId, @DonationAmount, @DonationDate);", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@UserId", this.Id));
      cmd.Parameters.Add(new SqlParameter("@CampaignId", donatedCampaign.Id));
      cmd.Parameters.Add(new SqlParameter("@DonationAmount", donationAmount));
      cmd.Parameters.Add(new SqlParameter("@DonationDate", date));

      SqlDataReader rdr = cmd.ExecuteReader();

      Donation newDonation = new Donation(this.Id, donatedCampaign.Id, donationAmount, date);

      while (rdr.Read())
      {
        newDonation.Id = rdr.GetInt32(0);
      }

      if (rdr != null)
      {
        rdr.Close();
      }
      DB.CloseConnection();

      return newDonation;
    }

    public void Update(string name, string login, string password, string address, string phoneNumber, string email)
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("UPDATE users SET name = @Name, login = @Login, password = @Password, address = @Address, phone_number = @PhoneNumber, email = @Email OUTPUT INSERTED.name, INSERTED.login, INSERTED.password, INSERTED.address, INSERTED.phone_number, INSERTED.email WHERE id = @UserId;", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@Name", name));
      cmd.Parameters.Add(new SqlParameter("@Login", login));
      cmd.Parameters.Add(new SqlParameter("@Password", password));
      cmd.Parameters.Add(new SqlParameter("@Address", address));
      cmd.Parameters.Add(new SqlParameter("@PhoneNumber", phoneNumber));
      cmd.Parameters.Add(new SqlParameter("@Email", email));
      cmd.Parameters.Add(new SqlParameter("@UserId", this.Id));


      SqlDataReader rdr = cmd.ExecuteReader();

      while(rdr.Read())
      {
        this.Name = rdr.GetString(0);
        this.Login = rdr.GetString(1);
        this.Password = rdr.GetString(2);
        this.ContactInfo.Address = rdr.GetString(3);
        this.ContactInfo.PhoneNumber = rdr.GetString(4);
        this.ContactInfo.Email = rdr.GetString(5);
      }

      if (rdr != null)
      {
        rdr.Close();
      }
      DB.CloseConnection();
    }

    public List<Campaign> GetCampaigns()
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("SELECT * FROM campaigns WHERE owner_id = @UserId;", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@UserId", this.Id));

      SqlDataReader rdr = cmd.ExecuteReader();

      List<Campaign> allCampaigns = new List<Campaign>{};
      while(rdr.Read())
      {
        int id = rdr.GetInt32(0);
        string name = rdr.GetString(1);
        string description = rdr.GetString(2);
        int goal = rdr.GetInt32(3);
        int balance = rdr.GetInt32(4);
        DateTime start = rdr.GetDateTime(5);
        DateTime end = rdr.GetDateTime(6);
        int categoryId = rdr.GetInt32(7);
        int ownerId = rdr.GetInt32(8);

        Campaign newCampaign = new Campaign(name, description, goal, balance, start, end, categoryId, ownerId, id);
        allCampaigns.Add(newCampaign);
      }

      if (rdr != null)
      {
        rdr.Close();
      }
      DB.CloseConnection();

      return allCampaigns;
    }
    public void DeleteSingleUser()
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("DELETE FROM users WHERE id = @UserId; DELETE FROM donations WHERE id = @UserId;", DB.GetConnection());

      cmd.Parameters.Add(new SqlParameter("@UserId", this.Id));
      cmd.ExecuteNonQuery();
      DB.CloseConnection();
    }

    public static void DeleteAll()
    {
      DB.CreateConnection();
      DB.OpenConnection();

      SqlCommand cmd = new SqlCommand("DELETE FROM users;", DB.GetConnection());

      cmd.ExecuteNonQuery();
      DB.CloseConnection();
    }
  }
}
