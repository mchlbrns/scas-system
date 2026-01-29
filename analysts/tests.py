import pytest
from django.contrib.auth.models import User
from analysts.models import Analyst


@pytest.fixture
def user(db):
    """Create a test user."""
    return User.objects.create_user(
        username='testuser',
        email='test@example.com',
        password='testpass123'
    )


@pytest.fixture
def analyst(db, user):
    """Create a test analyst."""
    return Analyst.objects.create(
        user=user,
        analyst_name='Test Analyst',
        role='ANALYST',
        email='analyst@example.com',
        is_active=True
    )


class TestAnalystModel:
    """Tests for the Analyst model."""

    def test_create_analyst(self, db):
        """Test creating an analyst without a user."""
        analyst = Analyst.objects.create(
            analyst_name='John Doe',
            role='ANALYST',
            email='john@example.com'
        )
        assert analyst.id is not None
        assert analyst.analyst_name == 'John Doe'
        assert analyst.role == 'ANALYST'
        assert analyst.is_active is True

    def test_analyst_with_user(self, analyst, user):
        """Test analyst linked to a user."""
        assert analyst.user == user
        assert analyst.user.username == 'testuser'

    def test_analyst_str_representation(self, analyst):
        """Test the string representation of an analyst."""
        expected = 'Test Analyst (Analyst)'
        assert str(analyst) == expected

    def test_analyst_role_choices(self, db):
        """Test all valid role choices."""
        for role_code, role_display in Analyst.ROLE_CHOICES:
            analyst = Analyst.objects.create(
                analyst_name=f'{role_display} User',
                role=role_code,
                email=f'{role_code.lower()}@example.com'
            )
            assert analyst.role == role_code

    def test_analyst_timestamps(self, analyst):
        """Test that timestamps are automatically set."""
        assert analyst.created_at is not None
        assert analyst.updated_at is not None

    def test_analyst_default_is_active(self, db):
        """Test that is_active defaults to True."""
        analyst = Analyst.objects.create(
            analyst_name='Active User',
            role='ANALYST'
        )
        assert analyst.is_active is True
