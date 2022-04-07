package account.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import account.bean.AccountDTO;

@Repository
@Transactional
public class AccountDAOMybatis implements AccountDAO {
	@Autowired
	private SqlSession sqlSession;

	public AccountDTO getAccountByUserId(int userId) {
		return sqlSession.selectOne("accountSQL.getAccountByUserId", userId);
	}

	@Override
	public void registerAccount(AccountDTO accountDTO) {
		sqlSession.insert("accountSQL.registerAccount", accountDTO);
	}
	
	@Override
	public void updateAccount(AccountDTO accountDTO) {
		sqlSession.update("accountSQL.updateAccount", accountDTO);
	}

}
