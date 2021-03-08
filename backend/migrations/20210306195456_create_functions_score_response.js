exports.up = function (knex) {
  return knex.raw(`
      CREATE FUNCTION practice.handle_score(card_id INTEGER, score INTEGER)
          RETURNS practice.card
          AS $$
      DECLARE
          card practice.card;
          ease_factor NUMERIC(7, 4);
          new_review_after TIMESTAMPTZ;
          response practice.score_response;
      BEGIN
          SELECT * INTO card FROM practice.card WHERE id = card_id;
          response = practice.score_response(score, card.spacing, card.ease_factor);
          new_review_after = card.review_after + interval '1 day' * response.spacing;

          UPDATE practice.card SET
            spacing = response.spacing,
            ease_factor = response.ease_factor,
            review_after = new_review_after,
                seq = CASE WHEN response.spacing = 0 THEN (
                SELECT COALESCE(MAX(seq), 0) + 1 FROM practice.card WHERE review_after < CURRENT_TIMESTAMP AND archived = FALSE)
                ELSE
                    0
                END
          WHERE
            id = card_id
        RETURNING * INTO card;
        INSERT INTO practice.response(score, review_after, spacing, ease_factor, card_id, person_id) VALUES (score, new_review_after, response.spacing, response.ease_factor, card_id, card.person_id);
        RETURN card;
      END;
      $$
      language plpgsql
      VOLATILE
      SECURITY DEFINER;
    `);
};

exports.down = function (knex) {
  return knex.raw(`
      DROP FUNCTION practice.handle_score(INTEGER, INTEGER);
    `);
};
